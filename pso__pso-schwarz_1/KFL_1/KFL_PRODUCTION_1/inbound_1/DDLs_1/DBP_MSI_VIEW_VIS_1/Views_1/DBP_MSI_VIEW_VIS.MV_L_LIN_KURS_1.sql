CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_LIN_KURS_1
-- AP0008358, 05.04.2016, srom0404,GSL Kurse hinzugekommen
-- 20161121 ssch0611 : COALESCE
-- AP0038371 05.02.19 Awol2209: UWU aufgenommen
-- 20240807 muellerpatri : Filter auf "PRG" entfernt
(
mandant_id
,lin_kurs_id
,lin_kursgruppe_id
,sortkz
,lin_bericht
)
AS
   SELECT v01.mandant_id, v01.lin_kurs_id, v01.lin_kursgruppe_id, v01.sortkz, COALESCE(v01.lin_bericht,'')
   FROM dbp_view.v_l_lin_kurs_1 v01
   WHERE lin_bericht = 'VIS'
   OR lin_bericht IS NULL
   OR lin_bericht = 'GSL'
   --OR lin_bericht = 'PRG'
   OR lin_bericht = 'UWU'
   OR lin_bericht = 'EWL'
;