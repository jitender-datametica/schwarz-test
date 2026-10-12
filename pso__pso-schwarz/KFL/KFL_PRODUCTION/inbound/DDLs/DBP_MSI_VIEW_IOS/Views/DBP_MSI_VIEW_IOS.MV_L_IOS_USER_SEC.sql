CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_L_IOS_USER_SEC as
   Select
   *
   From dbp_security.l_msi_user
   where msi_produkt_bez like 'IOS' ;