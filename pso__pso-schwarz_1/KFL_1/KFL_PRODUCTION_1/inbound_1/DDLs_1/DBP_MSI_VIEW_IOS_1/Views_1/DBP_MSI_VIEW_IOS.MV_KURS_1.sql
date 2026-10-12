CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_KURS_1
(
kurstyp_id
,von_wrg_id
,dat_von
,dat_bis
,umrechnungskurs
,nach_wrg_id
)
AS
   SELECT
   kurstyp_id, von_wrg_id, dat_von, dat_bis, umrechnungskurs, nach_wrg_id
   FROM dbp_view.v_kurs_1;