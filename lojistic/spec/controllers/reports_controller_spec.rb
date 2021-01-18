describe ReportsController, type: :controller do
  let(:report) { create(:report) }

  describe "GET #index" do
    it "is successful" do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe "GET #show" do
    it "is successful" do
      get :show, params: { id: report.id }
      expect(response.status).to eq(200)
    end
  end

  describe "GET #new" do
    it "is successful" do
      get :new
      expect(response.status).to eq(200)
    end
  end

  describe "POST #preview" do
    it "is successful" do
      new_report = { report_type: 'InvoiceSummary', start_date: 10.days.ago, end_date: 5.days.ago }
      post :preview, params: { report: new_report }
      expect(response.status).to eq(200)
    end
  end

  describe "POST #create" do
    it "is successful and redirects to index page" do
      new_report = { report_type: 'InvoiceSummary', start_date: 10.days.ago, end_date: 5.days.ago }
      post :create, params: { report: new_report }
      expect(response.status).to eq(302)
    end
  end

  describe "DELETE #destroy" do
    it "is successful and redirects to index page" do
      report_to_delete = create(:report)
      delete :destroy, params: { id: report_to_delete.id }
      expect(response.status).to eq(302)
    end
  end
end