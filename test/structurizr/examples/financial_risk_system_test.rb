# frozen_string_literal: true

###
# This is a simple (incomplete) example C4 model based upon the financial risk system
# architecture kata, which can be found at http://bit.ly/sa4d-risksystem
#
# Source: https://github.com/structurizr/java/blob/829738a1c7fea2e786239958a891599135c0d906/structurizr-examples/src/com/structurizr/example/FinancialRiskSystem.java
# Updated at: 2017-07-23
module Structurizr
  module Examples
    class FinancialRiskSystem < Minitest::Test
      TAG_ALERT = 'Alert'

      def test_definition
        workspace = Workspace.new('Financial Risk System', 'This is a simple (incomplete) example C4 model based upon the financial risk system architecture kata, which can be found at http://bit.ly/sa4d-risksystem')
        model = workspace.getModel

        financialRiskSystem = model.addSoftwareSystem('Financial Risk System', "Calculates the bank's exposure to risk for product X.")

        businessUser = model.addPerson('Business User', 'A regular business user.')
        businessUser.uses(financialRiskSystem, 'Views reports using')

        configurationUser = model.addPerson('Configuration User', 'A regular business user who can also configure the parameters used in the risk calculations.')
        configurationUser.uses(financialRiskSystem, 'Configures parameters using')

        tradeDataSystem = model.addSoftwareSystem('Trade Data System', 'The system of record for trades of type X.')
        financialRiskSystem.uses(tradeDataSystem, 'Gets trade data from')

        referenceDataSystem = model.addSoftwareSystem('Reference Data System', 'Manages reference data for all counterparties the bank interacts with.')
        financialRiskSystem.uses(referenceDataSystem, 'Gets counterparty data from')

        referenceDataSystemV2 = model.addSoftwareSystem('Reference Data System v2.0', 'Manages reference data for all counterparties the bank interacts with.')
        referenceDataSystemV2.addTags('Future State')
        financialRiskSystem.uses(referenceDataSystemV2, 'Gets counterparty data from').addTags('Future State')

        emailSystem = model.addSoftwareSystem('E-mail system', "The bank's Microsoft Exchange system.")
        financialRiskSystem.uses(emailSystem, 'Sends a notification that a report is ready to')
        emailSystem.delivers(businessUser, 'Sends a notification that a report is ready to', 'E-mail message', InteractionStyle::Asynchronous)

        centralMonitoringService = model.addSoftwareSystem('Central Monitoring Service', "The bank's central monitoring and alerting dashboard.")
        financialRiskSystem.uses(centralMonitoringService, 'Sends critical failure alerts to', 'SNMP', InteractionStyle::Asynchronous).addTags(TAG_ALERT)

        activeDirectory = model.addSoftwareSystem('Active Directory', "The bank's authentication and authorisation system.")
        financialRiskSystem.uses(activeDirectory, 'Uses for user authentication and authorisation')

        views = workspace.getViews
        contextView = views.createSystemContextView(financialRiskSystem, 'Context', 'An example System Context diagram for the Financial Risk System architecture kata.')
        contextView.addAllSoftwareSystems
        contextView.addAllPeople

        styles = views.getConfiguration.getStyles
        financialRiskSystem.addTags('Risk System')

        styles.addElementStyle(Tags::ELEMENT).color('#ffffff').fontSize(34)
        styles.addElementStyle('Risk System').background('#550000').color('#ffffff')
        styles.addElementStyle(Tags::SOFTWARE_SYSTEM).width(650).height(400).background('#801515').shape(Shape::RoundedBox)
        styles.addElementStyle(Tags::PERSON).width(550).background('#d46a6a').shape(Shape::Person)

        styles.addRelationshipStyle(Tags::RELATIONSHIP).thickness(4).dashed(false).fontSize(32).width(400)
        styles.addRelationshipStyle(Tags::SYNCHRONOUS).dashed(false)
        styles.addRelationshipStyle(Tags::ASYNCHRONOUS).dashed(true)
        styles.addRelationshipStyle(TAG_ALERT).color('#ff0000')

        styles.addElementStyle('Future State').opacity(30).border(Border::Dashed)
        styles.addRelationshipStyle('Future State').opacity(30).dashed(true)

        template = StructurizrDocumentationTemplate.new(workspace.to_java)
        documentationRoot = java.io.File.new(File.join(__dir__, 'financialrisksystem'))
        template.addContextSection(financialRiskSystem, java.io.File.new(documentationRoot, 'context.adoc'))
        template.addFunctionalOverviewSection(financialRiskSystem, java.io.File.new(documentationRoot, 'functional-overview.md'))
        template.addQualityAttributesSection(financialRiskSystem, java.io.File.new(documentationRoot, 'quality-attributes.md'))
        template.addImages(documentationRoot)
      end
    end
  end
end
