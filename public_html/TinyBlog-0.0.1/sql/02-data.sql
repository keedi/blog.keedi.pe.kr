--
-- Dumping data for table `user`
--

INSERT INTO `user` VALUES (1,'admin','admin','Administrator',NULL,NULL);
INSERT INTO `user` VALUES (2,'user','user','User',NULL,NULL);
INSERT INTO `user` VALUES (3,'guest','guest','Guest',NULL,NULL);

--
-- Dumping data for table `role`
--

INSERT INTO `role` VALUES (1,'admin',NULL,NULL);
INSERT INTO `role` VALUES (2,'user',NULL,NULL);
INSERT INTO `role` VALUES (3,'guest',NULL,NULL);

--
-- Dumping data for table `user_role`
--

INSERT INTO `user_role` VALUES (1,1,NULL,NULL);
INSERT INTO `user_role` VALUES (1,2,NULL,NULL);
INSERT INTO `user_role` VALUES (1,3,NULL,NULL);
INSERT INTO `user_role` VALUES (2,2,NULL,NULL);
INSERT INTO `user_role` VALUES (2,3,NULL,NULL);
INSERT INTO `user_role` VALUES (3,3,NULL,NULL);
