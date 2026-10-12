CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WUP_ARBEITSR_NAME_SPR_ZU_1
AS
   -- LOOKUP/SPRACHE Arbeitsrechtler
   -- Basis Techn. Platz ebene 2
   -- 20151130 Initial + Test_1 Mehrsprachigkeit in Spalten
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT  DISTINCT
   mandant_id, tp_arbeitsrecht_name                                         -- ID
   , tp_arbeitsrecht_name_trans AS tp_arbeitsrecht_name_bez, tp_arbeitsrecht_name_trans AS tp_arbeitsrecht_name_bez_de, tp_arbeitsrecht_name_trans AS tp_arbeitsrecht_name_bez_cz, tp_arbeitsrecht_name_trans AS tp_arbeitsrecht_name_bez_sk, tp_arbeitsrecht_name_trans AS tp_arbeitsrecht_name_bez_hr, tp_arbeitsrecht_name_trans AS tp_arbeitsrecht_name_bez_pl, tp_arbeitsrecht_name_trans AS tp_arbeitsrecht_name_bez_ro, tp_arbeitsrecht_name_bez   AS tp_arbeitsrecht_name_bez_bg
   FROM
   (
   SELECT DISTINCT
   mandant_id, tp_arbeitsrecht_name, CASE
   WHEN tp_arbeitsrecht_name = ' ' THEN 'nicht zugeordnet'
   ELSE tp_arbeitsrecht_name
   END AS tp_arbeitsrecht_name_bez, CASE
   WHEN mandant_id = 8 THEN dbp_process.Transcriptc(tp_arbeitsrecht_name_bez)
   ELSE tp_arbeitsrecht_name_bez
   END AS tp_arbeitsrecht_name_trans
   FROM dbp_view.v_techn_platz_ebene_2_per_1
   WHERE
   dat_bis = '9999-12-31'
   ) tpe2;