require 'rails_helper'

RSpec.describe "headings/show", type: :view do
  before(:each) do
    @heading = assign(:heading, Heading.create!(
      :member_id => 2,
      :kind => "Kind",
      :name => "Name"
    ))
  end

  xit "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Kind/)
    expect(rendered).to match(/Name/)
  end
end
