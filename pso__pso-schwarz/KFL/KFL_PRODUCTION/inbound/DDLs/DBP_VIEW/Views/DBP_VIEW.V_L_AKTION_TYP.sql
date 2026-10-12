create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_L_AKTION_TYP(
	MANDANT_ID COMMENT 'Mandant im DWH',
	AKTION_TYP_ID COMMENT 'ID des Typs die Art der Aktion.',
	AKTION_TYP_BEZ COMMENT 'Bezeichnung des Typs die Art der Aktion.'
) COMMENT='Lookup-Tabelle für den Typ der Aktion. KDN = Promotion erhaltbar wenn App verwendet wird; KDP = Promotion nur für einen gezielten Nutzerkreis erhaltbar (bspw. personalisiert); KDI = Promotion die bei einem externen Partner erworben wurde (bspw.Partner Coupon, SMP Coupon, Gutschein von Partner); KPB = Promotion erhalbar über Payback Card, nur im Polen gültig,'
 as 
    SELECT 
        mandant_id,
        aktion_typ_id,
        aktion_typ_bez

FROM DBP_DATA.L_AKTION_TYP ;
