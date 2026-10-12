CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_L_IOS_USER_SEC_2 as
   Select
   *
   From dbp_security.l_msi_user_2
   where msi_produkt_bez like 'IOS' ;