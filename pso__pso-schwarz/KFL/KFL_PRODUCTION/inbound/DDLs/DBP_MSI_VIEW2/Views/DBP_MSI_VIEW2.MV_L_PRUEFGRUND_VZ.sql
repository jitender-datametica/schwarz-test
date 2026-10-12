CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_L_PRUEFGRUND_VZ
-- EK-3088954 pruef_id 220 wurde entfernt 28.09.12/sschuecke --
-- Einschränkung auf spr_id = 22, da mittlerweile Mehrsprachigkeit 16.05.2018 sschuecke
(
pruef_id
,mandant_id
,spr_id
,pruef_bez
,z_arbeitsgebiet_id
)
AS
   SELECT
   pruef_id, mandant_id, spr_id, pruef_bez, CASE WHEN z_arbeitsgebiet_id = 0 THEN 'Z' WHEN z_arbeitsgebiet_id = 1 THEN 'S' ELSE ' ' END AS z_arbeitsgebiet_id
   FROM dbp_view.v_l_pruefgrund
   WHERE  mandant_id = 1
   AND spr_id = 22
   AND z_arbeitsgebiet_id = 1
   AND pruef_id IN
   (100, 107, 108, 126, 127, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 214, 215, 216, 217, 218, 219, 221, 222, 223,224, 225,
   226, 227, 230, 231, 233, 235, 236, 240, 241, 299, 308, 310, 344, 363, 499, 501, 502, 514, 515, 519, 523, 536,
   537, 538, 539, 540, 599, 600, 601, 602, 603, 615, 621, 910, 911, 916, 925, 994)
   OR z_arbeitsgebiet_id = 0
   AND pruef_id IN
   (110, 111, 112, 117, 119, 120, 126, 127, 133, 134, 416, 420, 421, 422, 425, 426, 433, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456)
;