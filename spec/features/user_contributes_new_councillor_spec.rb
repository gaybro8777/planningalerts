require "spec_helper"

feature "Contributing new councillors for an authority" do
  let(:authority) { create(:authority, full_name: "Casey City Council") }

  context "when the feature flag is off" do
    it "isn't available" do
      visit new_authority_councillor_contribution_path(authority.short_name_encoded)

      expect(page.status_code).to eq 404
    end
  end

  context "when the feature flag is on" do
    around do |test|
      with_modified_env CONTRIBUTE_COUNCILLORS_ENABLED: "true" do
        test.run
      end
    end

    it "successfully with three councillors and one blank councillor" do
      visit new_authority_councillor_contribution_path(authority.short_name_encoded)

      within ".councillor-contribution-councillors fieldset" do
        fill_in "Full name", with: "Mila Gilic"
        fill_in "Email", with: "mgilic@casey.vic.gov.au"
      end

      click_button "Add another councillor"

      within ".councillor-contribution-councillors fieldset" do
        fill_in "Full name", with: "Rosalie Crestani"
        fill_in "Email", with: "rcrestani@casey.vic.gov.au"
      end

      click_button "Add another councillor"

      within ".councillor-contribution-councillors fieldset" do
        fill_in "Full name", with: "Rosalie Crestani"
        fill_in "Email", with: "rcrestani@casey.vic.gov.au"
      end

      click_button "Add another councillor"

      click_button "Submit 4 new councillors"

      expect(page).to have_content "Thank you"
    end

    it "successfully with three councillors" do
      visit new_authority_councillor_contribution_path(authority.short_name_encoded)

      within ".councillor-contribution-councillors fieldset" do
        fill_in "Full name", with: "Mila Gilic"
        fill_in "Email", with: "mgilic@casey.vic.gov.au"
      end

      click_button "Add another councillor"

      within ".councillor-contribution-councillors fieldset" do
        fill_in "Full name", with: "Rosalie Crestani"
        fill_in "Email", with: "rcrestani@casey.vic.gov.au"
      end

      click_button "Add another councillor"

      within ".councillor-contribution-councillors fieldset" do
        fill_in "Full name", with: "Rosalie Crestani"
        fill_in "Email", with: "rcrestani@casey.vic.gov.au"
      end

      click_button "Submit 3 new councillors"

      expect(page).to have_content "Thank you"
    end

    it "successfully display the list of suggested councillor in fieldset" do
      visit new_authority_councillor_contribution_path(authority.short_name_encoded)

      within ".councillor-contribution-councillors fieldset" do
        fill_in "Full name", with: "Mila Gilic"
        fill_in "Email", with: "mgilic@casey.vic.gov.au"
      end

      click_button "Add another councillor"

      find_field("Full name", with: "Mila Gilic")
      find_field("Email", with: "mgilic@casey.vic.gov.au")
    end
  end
end
