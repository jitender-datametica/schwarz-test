CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_L_CPR_SUCHFELD_1
(

 --20170425 hmue2308: Redesign IOS
 --AP0004983, SPEC0020558
 --Seperate View für Suchfeld_Prompt
 -- 20200302 cbru1709: neues Feld cpr_suchfeld_akt_fg, entfernen Referenz zu projekt_bauabschnitt

 cpr_suchfeld_id,
 cpr_suchfeld,
 cpr_suchfeld_akt_fg

)
AS

   SELECT DISTINCT

    v01.cpr_suchfeld_id,
   v01.cpr_suchfeld,
   v01.cpr_suchfeld_akt_fg

  FROM dbp_view.v_l_cpr_suchfeld_1 v01;