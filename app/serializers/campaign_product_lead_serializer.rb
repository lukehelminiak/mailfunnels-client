class CampaignProductLeadSerializer < ActiveModel::Serializer
  attributes :id, :product_identifier, :sold, :sale_ammount, :BuyDate, :ClickDate
  has_one :app
  has_one :EmailList
  has_one :email
end
