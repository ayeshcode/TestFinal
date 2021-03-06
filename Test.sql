USE [SMS]
GO
/****** Object:  Table [dbo].[Status]    Script Date: 30/06/2020 01:33:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Status] [nvarchar](50) NULL,
	[Scenario] [nvarchar](50) NULL,
	[TestDescription] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SystemUsers]    Script Date: 30/06/2020 01:33:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemUsers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[Status] [nvarchar](50) NULL,
	[Role] [nvarchar](50) NULL,
 CONSTRAINT [PK_SystemUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Employee]    Script Date: 30/06/2020 01:33:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Employee](
	[Sr_no] [int] IDENTITY(1,1) NOT NULL,
	[Emp_name] [nvarchar](200) NULL,
	[City] [nvarchar](200) NULL,
	[State] [nvarchar](200) NULL,
	[Country] [nvarchar](200) NULL,
	[Department] [nvarchar](200) NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Employee]    Script Date: 30/06/2020 01:33:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Sp_Employee] 
@Sr_no int , 
@Emp_name nvarchar(500), 
@City nvarchar(500), 
@STATE nvarchar(500), 
@Country nvarchar(500), 
@Department nvarchar(500), 
@flag nvarchar(50) 
AS 
 begin 
 IF(@flag='insert') 
 BEGIN 
 INSERT INTO tbl_Employee
 ( 
     Emp_name, 
     City, 
     State, 
     Country, 
     Department 
 ) 
 VALUES 
 (   @Emp_name, 
     @City, 
     @State, 
     @Country, 
     @Department 
     ) 
 end 
 ELSE IF(@flag='update') 
 BEGIN 
   UPDATE dbo.tbl_Employee SET 
    Emp_name=@Emp_name,City=@City,State=@STATE,Country=@Country,Department=@Department 
 WHERE Sr_no=@Sr_no 
 END 
  ELSE IF(@flag='delete') 
 BEGIN 
   DELETE FROM tbl_Employee  WHERE Sr_no=@Sr_no 
 END 
  ELSE IF(@flag='getid') 
 BEGIN 
   SELECT * FROM tbl_Employee WHERE Sr_no=@Sr_no 
 END 
 ELSE IF(@flag='get') 
 BEGIN 
   SELECT * FROM tbl_Employee 
 end 
 END
GO
/****** Object:  StoredProcedure [dbo].[Sp_User]    Script Date: 30/06/2020 01:33:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Sp_User] 
@Id int , 
@UserName nvarchar(500), 
@Password nvarchar(500),  
@Email nvarchar(500), 
@Status nvarchar(500), 
@Role nvarchar(50) ,
@flag nvarchar(50)

AS 
 begin 
 IF(@flag='insert') 
 BEGIN 
 INSERT INTO dbo.SystemUsers
 ( 
     UserName, 
     Password, 
     Email, 
     Status, 
     Role 
 ) 
 VALUES 
 (  @UserName,
  @Password,   
  @Email , 
  @Status  ,
  @Role   
     ) 
 end 
 ELSE IF(@flag='update') 
 BEGIN 
   UPDATE dbo.SystemUsers  SET 
    UserName=@UserName,Password=@Password,Email=@Email,Role=@Role
 WHERE Id=@Id 
 END 
  ELSE IF(@flag='delete') 
 BEGIN 
   DELETE FROM SystemUsers  WHERE Id=@Id 
 END 
  ELSE IF(@flag='getid') 
 BEGIN 
   SELECT * FROM SystemUsers WHERE Id=@Id
 END 
 ELSE IF(@flag='get') 
 BEGIN 
   SELECT * FROM SystemUsers 
 end 
 END
GO
