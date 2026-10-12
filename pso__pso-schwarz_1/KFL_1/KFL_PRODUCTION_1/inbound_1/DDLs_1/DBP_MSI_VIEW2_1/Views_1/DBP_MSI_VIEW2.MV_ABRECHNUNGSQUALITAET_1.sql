CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ABRECHNUNGSQUALITAET_1
(
 kjmo
,gp_id
,rechnung_anz
,rechnung_netto
,rechnung_maschinell_anz
,rechnung_manuell_anz
,belastungsanzeigen_anz
,belastungsanzeigen_netto
,rueckbelastungsanzeigen_anz
,rueckbelastungsanzeigen_netto
)
AS
   SELECT
   kjmo, gp_id, rechnung_anz, rechnung_netto, rechnung_maschinell_anz, rechnung_manuell_anz, belastungsanzeigen_anz, belastungsanzeigen_netto, rueckbelastungsanzeigen_anz, rueckbelastungsanzeigen_netto
   FROM dbp_view.v_abrechnungsqualitaet_1;