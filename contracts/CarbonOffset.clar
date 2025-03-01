;; CarbonOffset: Decentralized Climate Action Protocol
;; Version: 1.0.0

(define-data-var program-steward principal tx-sender)
(define-data-var carbon-vault uint u0)
(define-data-var impact-multiplier uint u100) ;; impact multiplied per block (example value)
(define-data-var last-calculated uint u0) ;; last block when impact was calculated
(define-map contributions principal uint)

;; Helper function to ensure only the program steward can perform certain actions
(define-private (is-steward (account principal))
  (begin
    (asserts! (is-eq account (var-get program-steward)) (err u100))
    (ok true)))

;; Initialize the contract
(define-public (activate (steward principal))
  (begin
    (asserts! (is-none (map-get? contributions steward)) (err u101))
    (var-set program-steward steward)
    (ok "Program activated")))

;; Contribute tokens to the carbon offset program
(define-public (contribute (amount uint))
  (begin
    (asserts! (> amount u0) (err u102))
    (let ((current-contribution (default-to u0 (map-get? contributions tx-sender))))
      (map-set contributions tx-sender (+ current-contribution amount))
      (var-set carbon-vault (+ (var-get carbon-vault) amount))
      (ok (+ current-contribution amount)))))

;; Calculate environmental impact for all participants
(define-public (calculate-impact)
  (begin
    (try! (is-steward tx-sender))
    (let ((current-block tenure-height)
          (last-calc (var-get last-calculated)))
      (asserts! (> current-block last-calc) (err u103))
      ;; Calculate impact based on blocks elapsed
      (let ((elapsed (- current-block last-calc))
            (total-impact (* elapsed (var-get impact-multiplier))))
        (var-set last-calculated current-block)
        (var-set carbon-vault (+ (var-get carbon-vault) total-impact))
        (ok total-impact)))))

;; Claim carbon credits and impact
(define-public (claim-credits)
  (begin
    (let ((contributor-amount (default-to u0 (map-get? contributions tx-sender))))
      (asserts! (> contributor-amount u0) (err u104))
      (let ((total-amount (var-get carbon-vault))
            (new-impact (* (var-get impact-multiplier) (- tenure-height (var-get last-calculated))))
            (percentage (/ (* contributor-amount u100000) total-amount)))
        ;; Update amounts and calculate impact percentage
        (let ((impact-share (/ (* percentage new-impact) u100000)))
          (map-delete contributions tx-sender)
          (var-set carbon-vault (- (var-get carbon-vault) contributor-amount))
          (ok (+ contributor-amount impact-share)))))))