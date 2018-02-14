require 'test_helper'

class ConsignmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @consignment = consignments(:one)
  end

  test "should get index" do
    get consignments_url
    assert_response :success
  end

  test "should get new" do
    get new_consignment_url
    assert_response :success
  end

  test "should create consignment" do
    assert_difference('Consignment.count') do
      post consignments_url, params: { consignment: { additional_cost: @consignment.additional_cost, charge: @consignment.charge, compensation: @consignment.compensation, delivered_on: @consignment.delivered_on, merchant_id: @consignment.merchant_id, merchant_order_no: @consignment.merchant_order_no, package_description: @consignment.package_description, payment_status: @consignment.payment_status, plan_id: @consignment.plan_id, price: @consignment.price, receiver_addr: @consignment.receiver_addr, receiver_name: @consignment.receiver_name, receiver_phone: @consignment.receiver_phone, tracking_id: @consignment.tracking_id, weight: @consignment.weight } }
    end

    assert_redirected_to consignment_url(Consignment.last)
  end

  test "should show consignment" do
    get consignment_url(@consignment)
    assert_response :success
  end

  test "should get edit" do
    get edit_consignment_url(@consignment)
    assert_response :success
  end

  test "should update consignment" do
    patch consignment_url(@consignment), params: { consignment: { additional_cost: @consignment.additional_cost, charge: @consignment.charge, compensation: @consignment.compensation, delivered_on: @consignment.delivered_on, merchant_id: @consignment.merchant_id, merchant_order_no: @consignment.merchant_order_no, package_description: @consignment.package_description, payment_status: @consignment.payment_status, plan_id: @consignment.plan_id, price: @consignment.price, receiver_addr: @consignment.receiver_addr, receiver_name: @consignment.receiver_name, receiver_phone: @consignment.receiver_phone, tracking_id: @consignment.tracking_id, weight: @consignment.weight } }
    assert_redirected_to consignment_url(@consignment)
  end

  test "should destroy consignment" do
    assert_difference('Consignment.count', -1) do
      delete consignment_url(@consignment)
    end

    assert_redirected_to consignments_url
  end
end
