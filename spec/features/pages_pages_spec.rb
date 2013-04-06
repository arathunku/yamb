require 'spec_helper'


describe "Pages" do
  describe "visible on root" do
    it do
      get root_path
      expect(response.body).to include("Persona")
    end
  end
end