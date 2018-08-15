require_relative '../test_helper'

class Ufebs::Documents::InvoiceOrderTest < MiniTest::Test
def test_it_maps_to_valid_xml_with_processing_details
      po  = Ufebs::Documents::InvoiceOrder.new(
        number:             7,
        sum:                150000,
        receipt_date:       Time.now,
        ed_author:          '4525595000',
        acc_doc:            {
          number: '3',
          date:   Time.now
        },
        purpose:            'оплата в том числе ндс 4000 руб',
        payment_precedence: '69',
        payer:              {
          name:         'ООО ТЕСТ',
          account:      '40702810200203001037',
          inn:          '7726274727',
          bank_bic:     '044525545',
          bank_account: '30101810300000000545'
        },
        payee:              {
          name:         'ООО ТЕСТ',
          account:      '40702810200203001037',
          inn:          '7726274727',
          bank_bic:     '044525545',
          bank_account: '30101810300000000545'
        },
        processing_details: {
          session: {
            session_type:    'NURG',
            settlement_time: '14:00:26'
          }
        }
      )
      doc = Nokogiri::XML(po.to_xml)
      puts Ufebs.validate(doc).errors
      assert Ufebs.validate(doc).valid?
    end

  def test_it_maps_to_valid_xml
    po = Ufebs::Documents::InvoiceOrder.new(
      number: 7,
      sum: 150000,
      receipt_date: Time.now,
      ed_author: '4525595000',
      system_code: '02',
      trans_kind: '06',
      acc_doc: { number: '3', date: Time.now },
      purpose: 'оплата в том числе ндс 4000 руб',
      payer: {
        name: 'ООО ТЕСТ',
        account: '40702810200203001037',
        inn: '7726274727',
        bank_bic: '044525545',
        bank_account: '30101810300000000545'
      },
      payee: {
        name: 'ООО ТЕСТ',
        account: '40702810200203001037',
        inn: '7726274727',
        bank_bic: '044525545',
        bank_account: '30101810300000000545'
      },
      departmental_info: {
        kbk: '18210301000010000110',
        okato: '45263591000',
        drawer_status: '01',
        tax_period: 'МС.03.2017',
        tax_payt_kind: 'НС',
        doc_no: '111',
        payt_reason: 'ТП'
      }
    )
    doc = Nokogiri::XML(po.to_xml)

    puts Ufebs.validate(doc).errors
    assert Ufebs.validate(doc).valid?
  end
end