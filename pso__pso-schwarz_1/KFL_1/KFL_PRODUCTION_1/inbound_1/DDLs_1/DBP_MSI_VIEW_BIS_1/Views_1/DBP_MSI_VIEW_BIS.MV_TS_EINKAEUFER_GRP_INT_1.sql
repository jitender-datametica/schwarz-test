CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_TS_EINKAEUFER_GRP_INT_1
-- Zusatztabelle zu Lookuptabelle mv_l_einkaeufer_grp_int_1 mit Zusatzinfos für Transaction Service Berichte
-- 19.02.2015 twie: Cast von einkaeufer_int_id auf CHAR entfällt weil Quelle jetzt CHAR(3)

(
mandant_id
,einkaeufer_grp_id
,einkaeufer_grp_bez
,hat_lieferant_fg
)
AS
   SELECT
   99 AS mandant_id,
   v01.einkaeufer_int_id AS einkaeufer_grp_id,
   einkaeufer_int_name AS einkaeufer_grp_bez,
   CASE WHEN v02.einkaeufer_int_id IS NOT NULL THEN 1 ELSE 0 END AS hat_lieferant_fg
   FROM dbp_view.v_in_l_einkaeufer_int_1 v01
   LEFT JOIN dbp_msi_view_bis.ts_einkaeufer_int_lief_zu_1 v02
   ON v01.einkaeufer_int_id = v02.einkaeufer_int_id
   GROUP BY  mandant_id
   ,einkaeufer_grp_id
   ,einkaeufer_grp_bez
   ,hat_lieferant_fg
;