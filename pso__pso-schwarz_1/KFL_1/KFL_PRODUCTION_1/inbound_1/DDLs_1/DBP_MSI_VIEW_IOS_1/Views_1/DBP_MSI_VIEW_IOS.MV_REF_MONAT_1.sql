CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_REF_MONAT_1
(ref_monat)
AS
   select
   min(dat)
   from dbp_view.v_tag_1
   where akt_mo = 0;