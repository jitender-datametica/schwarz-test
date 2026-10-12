CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_L_IOS_USER_SEC_1 as
   Select
   *
   From dbp_security.l_msi_user_1
   where msi_produkt_bez like 'IOS' ;