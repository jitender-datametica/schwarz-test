CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_L_BELEG_ERFASSER_2
-- 20140526 kkaiser - initiale Erstellung für # 586188
-- 20150818 srom: korrektur, belegerfasser_id stand in hochkommata
(
beleg_erfasser_id
)
AS
   SELECT beleg_erfasser_id
   FROM dbp_view.v_l_beleg_erfasser_2;