CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_LIEFERANT_AUDIT_PER
-- 27.03.2014 twie: audit_qzahl aus Lieferanten Lookup in eigene Tabelle uebernommen, da jetzt historisiert ausgewertet
-- 21.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen

(
mandant_id
,in_lief_id
,dat_von
,dat_bis
,dat
,audit_qzahl
)
AS
   SELECT
   v01.mandant_id, v01.flw_lief_id AS in_lief_id, v01.dat_von, v01.dat_bis, v02.dat, v01.audit_qzahl
   FROM dbp_view.v_flw_lieferant_audit_per v01
   INNER JOIN dbp_view.v_tag v02
   ON v02.dat BETWEEN v01.dat_von AND v01.dat_bis
   AND v02.dat <= CURRENT_DATE +365;