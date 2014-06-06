require 'test_helper'

class JobReportsControllerTest < ActionController::TestCase
  setup do
    @job_report = job_reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:job_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create job_report" do
    assert_difference('JobReport.count') do
      post :create, job_report: { content: @job_report.content }
    end

    assert_redirected_to job_report_path(assigns(:job_report))
  end

  test "should show job_report" do
    get :show, id: @job_report
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @job_report
    assert_response :success
  end

  test "should update job_report" do
    patch :update, id: @job_report, job_report: { content: @job_report.content }
    assert_redirected_to job_report_path(assigns(:job_report))
  end

  test "should destroy job_report" do
    assert_difference('JobReport.count', -1) do
      delete :destroy, id: @job_report
    end

    assert_redirected_to job_reports_path
  end
end
