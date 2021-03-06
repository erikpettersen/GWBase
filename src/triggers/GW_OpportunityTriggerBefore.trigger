// Written by Dave Habib, copyright (c) 2011 ONE/Northwest
// This program is released under the GNU Affero General Public License, Version 3. http://www.gnu.org/licenses/

trigger GW_OpportunityTriggerBefore on Opportunity (before insert, before update) {
    
    // handle the user specifying the primary contact through the lookup field, not the ID field.
    if (Trigger.IsInsert) {
    	ONEN_OpportunityMaintenance.CheckPrimaryContactLookup(trigger.New);
    }
    
    // create a name for any opps without.
    if (Trigger.IsInsert && GW_TriggerSettings.ts.Enable_Opportunity_AutoName__c) {
        ONEN_OpportunityMaintenance.OpportunityAutoName(trigger.New);
    }
	
	// add membership origin, start, and end dates to membership opportunities
	if (Trigger.IsInsert && GW_TriggerSettings.ts.Enable_Auto_Membership_Dates__c) {
		GW_AutoMemberDates amd = new GW_AutoMemberDates();
		amd.memberDates(trigger.New);
	}
	
}