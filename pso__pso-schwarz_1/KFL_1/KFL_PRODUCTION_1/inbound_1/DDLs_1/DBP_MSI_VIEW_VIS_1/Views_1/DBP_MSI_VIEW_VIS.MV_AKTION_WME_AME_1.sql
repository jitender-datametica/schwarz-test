CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AKTION_WME_AME_1
AS
--30.07.2020 snik1809 AP0029549-SPEC0068832

SELECT
 mandant_id
      ,aktion_id
      ,aktionsart_id
      ,dat_von
      ,dat_bis
      ,zusatzinfo
 
FROM dbp_data.aktion_wme_ame_1;