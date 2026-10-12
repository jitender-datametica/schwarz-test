CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_WOCHE_START_DONNERSTAG_1
-- 09.09.2016, AP0011423, SPEC0014027, srom0404: initial
(
dat
,kjwo
,akt_wo
)
AS
   SELECT dat+3, kjwo, akt_wo
   FROM dbp_view.v_tag_1
;