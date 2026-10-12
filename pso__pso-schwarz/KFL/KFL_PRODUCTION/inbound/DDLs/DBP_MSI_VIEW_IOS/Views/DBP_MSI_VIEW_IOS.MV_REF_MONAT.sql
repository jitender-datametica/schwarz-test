CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_REF_MONAT
(ref_monat)
AS
   select
   min(dat)
   from dbp_view.v_tag
   where akt_mo = 0;