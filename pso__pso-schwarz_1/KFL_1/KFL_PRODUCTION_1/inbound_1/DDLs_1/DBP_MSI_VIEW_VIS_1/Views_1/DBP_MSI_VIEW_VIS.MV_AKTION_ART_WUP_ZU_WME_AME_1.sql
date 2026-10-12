CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AKTION_ART_WUP_ZU_WME_AME_1
AS
--30.06.2020 snik1809 AP0029549-SPEC0068832

SELECT
       mandant_id
      ,aktion_id
      ,art_id
      ,wup_id
      ,nb_id
   
FROM dbp_data.aktion_art_wup_zu_wme_ame_1;