Feature: Metatags
  In order to know that metatags are providing meaningful text for search engines
  As a website user
  I need to be able to trust that metatag works consistently

  @api
  Scenario: Evaluating migrated metatags
    Given I am on "en/content/drupal-wxt"
    Then the metatag attribute "dcterms.title" should have the value "Drupal WxT"
    And I am on "fr/contenu/wxt-drupal"
    Then the metatag attribute "dcterms.title" should have the value "WxT Drupal"

  @api @javascript
  Scenario: Evaluating created metatags
    Given I am logged in as a user with the "administrator" role
    When I visit "/node/add/wetkit-page"
      And I fill in the following:
        | Title                          | Testing WYSIWYG              |
        | Language                       | en                           |
        | body[und][0][format]           | wetkit_wysiwyg_text          |
        | metatags[title][value]         | SEO optimized title          |
        | metatags[description][value]   | SEO optimized description    |
        | metatags[keywords][value]      | SEO optimized keywords       |
        | workbench_moderation_state_new | published                    |
      And I press "Save"
      And I wait 2 seconds
    Then the "h1" element should contain "Testing title"
      And I should see "SEO optimized title" in the "Title" element
      And the metatag attribute "description" should have the value "My SEO optimized description"
      And the metatag attribute "keywords" should have the value "SEO optimized keywords"
