CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_aktion_typ_1 (mandant_id OPTIONS(description='Mandant_1 im DWH'),
aktion_typ_id OPTIONS(description='ID des Typs die Art_1 der Aktion.'), aktion_typ_bez
OPTIONS(description='Bezeichnung des Typs die Art_1 der Aktion.'))
OPTIONS(DESCRIPTION = `Lookup-Tabelle für den Typ der Aktion. KDN = Promotion erhaltbar wenn App verwendet wird; KDP = Promotion nur für einen gezielten Nutzerkreis erhaltbar (bspw. personalisiert); KDI = Promotion die bei einem externen Partner erworben wurde (bspw.Partner Coupon, SMP Coupon, Gutschein_1 von Partner); KPB = Promotion erhalbar über Payback Card, nur im Polen gültig,`)
AS SELECT mandant_id,
 aktion_typ_id,
 aktion_typ_bez
FROM kfl_production_dbp_data.l_aktion_typ_1;