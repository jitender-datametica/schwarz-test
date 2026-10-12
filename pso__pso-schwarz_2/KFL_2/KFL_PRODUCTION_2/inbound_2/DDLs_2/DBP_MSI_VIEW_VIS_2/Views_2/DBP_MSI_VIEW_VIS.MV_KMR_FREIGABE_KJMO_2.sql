CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_KMR_FREIGABE_KJMO_2
-- 11.09.2018 twie: SPEC0038393 Anlage_2 Transaction Bericht zur Freigabe Daten auf Ebene Land_2 / Monat_2
--                            Freigabe in KMR setzen, damit im VIS Cockpit Daten erst nach Freigabe angezeigt werden
--- 0910.2018 dsim: SPEC0043226

(
kjmo
,mandant_id
,freigabe_fg

)
AS
   SELECT
   kjmo, mandant_id, freigabe_fg

   FROM dbp_view.v_ts_kmr_freigabe_kjmo_2;