CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_LIN_KURSGRUPPEN_MAPPING_2
(
mandant_id
,lin_kursgruppe_id
,lin_kurs_id
)

   -- 2024-08-07 muellerpatri : Filter auf ungleich PRG hinzugefügt
AS
   SELECT mandant_id, lin_kursgruppe_id, lin_kurs_id
   FROM dbp_view.v_l_lin_kurs_2
   WHERE lin_bericht <> 'PRG';