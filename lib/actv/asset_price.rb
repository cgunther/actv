module ACTV
  class AssetPrice < Base

    attr_reader :effectiveDate, :priceAmt, :maxPriceAmt, :minPriceAmt

    alias effective_date effectiveDate
    alias amount priceAmt
    alias max_amount maxPriceAmt
    alias min_amount minPriceAmt
  end
end