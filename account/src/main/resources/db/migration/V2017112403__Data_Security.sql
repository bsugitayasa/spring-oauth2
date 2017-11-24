INSERT INTO s_permission (id, permission_label, permission_value) VALUES
  ('configuresystem', 'CONFIGURE_SYSTEM', 'Configure System'),
  ('editproduct', 'EDIT_PRODUCT', 'Edit Product'),
  ('viewproduct', 'VIEW_PRODUCT', 'View Product');

INSERT INTO s_role (id, description, name) VALUES
  ('superuser', 'SUPERUSER', 'Super User'),
  ('staff', 'STAFF', 'Staff'),
  ('manager', 'MANAGER', 'Manager');

INSERT INTO s_role_permission (id_role, id_permission) VALUES
  ('staff', 'viewproduct'),
  ('manager', 'viewproduct'),
  ('manager', 'editproduct'),
  ('superuser', 'viewproduct'),
  ('superuser', 'editproduct'),
  ('superuser', 'configuresystem');

INSERT INTO s_user (id, active, username, id_role) VALUES
  ('staff', true,'staff', 'staff');

INSERT INTO s_user_password (id_user, password) VALUES
  -- password : balicamp123 menggunakan BCryptPasswordEncoder
  ('staff', '$2a$10$mWAbi9UrOGaYK8mWNexZ7OfNM8BBaoO.eLGAn/PYnRyXdm/HHt8AW');
