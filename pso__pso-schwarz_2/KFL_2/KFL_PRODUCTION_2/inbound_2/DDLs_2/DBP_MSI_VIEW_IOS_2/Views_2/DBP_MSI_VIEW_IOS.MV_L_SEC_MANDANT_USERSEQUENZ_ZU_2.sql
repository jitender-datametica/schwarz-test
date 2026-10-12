CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_L_SEC_MANDANT_USERSEQUENZ_ZU_2 As
   SELECT mandant_id,  LOWER(usersequenz) AS usersequenz
   FROM dbp_security.ios_mandant_usersequenz_zu_2;