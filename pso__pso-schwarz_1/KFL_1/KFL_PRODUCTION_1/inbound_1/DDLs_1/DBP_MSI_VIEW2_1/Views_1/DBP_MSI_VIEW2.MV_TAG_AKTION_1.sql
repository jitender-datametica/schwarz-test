CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_TAG_AKTION_1
-- #616947 Werbewoche ist ab sofort flexibel, keine künstliche Woche_1 So-Sa mehr - sschuecke 20.05.2015
(
dat
,wtag_id
,kjwo
,akt_wo
)
AS
   SELECT
   dat, wtag_id, kjwo, akt_wo
   FROM dbp_view.v_tag_1;