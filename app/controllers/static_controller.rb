class StaticController < ApplicationController

  layout 'static'
  
  before_filter :set_user_data

  def risk_report
    @content = 
      [{title: 'Mining project management, infrastructure and civil engineering',
        content: [{title: 'Surface facilities',
                   content: [
                             'DRA Mining provides a total mining solution which includes: consulting services, exploration management, geology, studies, Competent Person reports, resource modeling, mine design, mine scheduling, surface and underground infrastructure, design and engineering, materials handling, construction management, operational support, maintenance and mine closure.',
                             'This service, which covers the entire spectrum of industrial, civil and structural design and construction, is managed by a specialist engineering and construction team.'
                    ]},
                  {title: 'Others',
                   content: 'This service, which covers the entire spectrum of industrial, civil and structural design and construction, is managed by a specialist engineering and construction team.'
                 }]},
        {title: 'Minerals processing plant design',
         content: [{content: 'DRA Mineral Projects has been successfully involved in some of the most challenging mine and processing developments in the world. The company has the expertise to conceptualise and design mineral processing plants from run-of-mine ore to saleable product in the platinum, coal, diamond, gold, ferrous and base metals, uranium and phosphate sectors, amongst others.'}]},
        {title: 'Project management for mineral processing plants',
         content: [{content: %q(DRA’s project management capabilities ensure total control across all types of projects. By drawing on its collective expertise, the company is able to direct the entire project process from conceptual feasibility to final hand-over and beyond. DRA offers fast track implementation when required, testing and inspection, construction management and control as well as office and conference facilities for sites in remote areas.)}] }]
  end

  def efficiency
    @indices = [
      ['accidents', 0, 0, 0, 1],
      ['emergencies', 0, 0, 0, 1],
      ['violations', 0, 5, 10, 17]
    ]
    @throughput_params = [
      ['value_of_realization', 13, 5, 12, 100],
      ['value_of_realization', 594, 575, 558, 800]
     ]
  end

  private

  def set_user_data
    @user_name = 'Dmitri Ivanov'
    @user_pic = 'ivanov.jpg'
  end

end
