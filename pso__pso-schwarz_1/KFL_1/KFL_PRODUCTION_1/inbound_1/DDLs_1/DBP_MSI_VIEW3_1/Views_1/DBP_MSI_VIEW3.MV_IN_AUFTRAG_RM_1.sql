CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_IN_AUFTRAG_RM_1
-- 18.10.2016, AP0002373, srom, separater Ausweis der Material und Lohnkosten
-- 25.04.2019 AP0027270, mcie, added dat_buch
-- 29.05.2019 AP0027270, mcie, removing auftrag_rm_pos_id, making values distinct
(
mandant_id
--,auftrag_rm_id
--,auftrag_rm_pos_id
,auftrag_id
,co_leistungsart_id
,storno_fg
,storno_zaehler
,dat_buch

)
AS
   SELECT distinct
   mandant_id, auftrag_id, co_leistungsart_id, storno_fg, storno_zaehler, dat_buch

   FROM dbp_view.v_in_auftrag_rm_1;