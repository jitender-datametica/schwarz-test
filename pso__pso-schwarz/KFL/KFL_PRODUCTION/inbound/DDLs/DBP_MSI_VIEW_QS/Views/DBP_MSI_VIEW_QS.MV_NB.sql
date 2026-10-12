CREATE OR REPLACE VIEW DBP_MSI_VIEW_QS.MV_NB
(
nb_id
, nb_bez
)
AS
SELECT
v01.nb_id
, v01.nb_bez

FROM dbp_view.v_nb v01;