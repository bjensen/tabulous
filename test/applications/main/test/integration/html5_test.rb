require File.expand_path("../integration_test_helper", File.dirname(__FILE__))
 
class Html5Test < ActionController::IntegrationTest

  def init(html5)
    use_initializer %Q{
      Tabulous.setup do |config|

        config.tabs = [
          #------------------------------------------------------------------------------------------------------#
          #    TAB NAME         |    DISPLAY TEXT     |    PATH                |    VISIBLE?    |    ENABLED?    #
          #------------------------------------------------------------------------------------------------------#
          [    :home_tab        ,    'Explanation'    ,    "/"                 ,    true        ,    true        ],
          [    :galaxies_tab    ,    'Galaxies'       ,    "/galaxies"         ,    true        ,    true        ],
          [    :stars_tab       ,    'Stars'          ,    "/stars"            ,    true        ,    true        ],
          [    :planets_tab     ,    'Planets'        ,    "/planets"          ,    true        ,    true        ],
          [    :subtabs_tab     ,    'Subtabs'        ,    "/subtabs/one"      ,    true        ,    true        ],
          [    :one_subtab      ,    'One'            ,    "/subtabs/one"      ,    true        ,    true        ],
          [    :two_subtab      ,    'Two'            ,    "/subtabs/two"      ,    true        ,    true        ],
          [    :three_subtab    ,    'Three'          ,    "/subtabs/three"    ,    true        ,    true        ],
          #------------------------------------------------------------------------------------------------------#
          #    TAB NAME         |    DISPLAY TEXT     |    PATH                |    VISIBLE?    |    ENABLED?    #
          #------------------------------------------------------------------------------------------------------#
        ]

        config.actions = [
          #-------------------------------------------------------------#
          #    CONTROLLER    |    ACTION          |    TAB              #
          #-------------------------------------------------------------#
          [    :home         ,    :all_actions    ,    :home_tab        ],
          [    :galaxies     ,    :all_actions    ,    :galaxies_tab    ],
          [    :stars        ,    :all_actions    ,    :stars_tab       ],
          [    :planets      ,    :all_actions    ,    :planets_tab     ],
          [    :subtabs      ,    :one            ,    :one_subtab      ],
          [    :subtabs      ,    :two            ,    :two_subtab      ],
          [    :subtabs      ,    :three          ,    :three_subtab    ],
          #-------------------------------------------------------------#
          #    CONTROLLER    |    ACTION          |    TAB              #
          #-------------------------------------------------------------#
        ]

        config.html5 = #{html5}

      end
    }
  end

  test "html5" do
    init(true)
    visit '/'
    assert page.has_css?('nav#tabs')
    click_link 'Subtabs'
    assert page.has_css?('nav#subtabs')
  end

  test "no html5" do
    init(false)
    visit '/'
    assert page.has_css?('div#tabs')
    click_link 'Subtabs'
    assert page.has_css?('div#subtabs')
  end

end
