CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_L_GEKU_PERSON_1
(
geku_person_id
,NAME
,vorname
,orga_nr
)
AS
   SELECT
   geku_person_id
   , NAME
   , vorname
   , orga_nr
   FROM dbp_view.v_l_geku_person_1;