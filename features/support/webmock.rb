require 'webmock/cucumber'

Before do
  stub_request(:post, "https://esaas-randomword.onrender.com/RandomWord").to_return(status: 200, headers: {},
                                                                              body: "testword")
end
