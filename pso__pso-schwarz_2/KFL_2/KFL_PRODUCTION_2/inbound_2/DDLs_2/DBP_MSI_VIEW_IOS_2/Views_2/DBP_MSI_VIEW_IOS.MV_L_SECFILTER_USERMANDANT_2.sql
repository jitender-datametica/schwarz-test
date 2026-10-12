CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_L_SECFILTER_USERMANDANT_2 as
   SELECT
   user_id, mandant_id
   FROM dbp_security.user_mandant_msiprodukt_zu_2
   WHERE msi_produkt_bez = 'IOS';