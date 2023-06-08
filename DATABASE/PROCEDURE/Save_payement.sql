
	CREATE PROCEDURE [dbo].[Save_Orders] @tblOrders  OrderDetails READONLY
	AS
	BEGIN
		SET NOCOUNT ON;

		INSERT INTO Orders(OrderNo, ProductId , Quantity , UserId , Status , PayementId , OrderDate)
		SELECT OrderNo , ProductId , Quantity , UserId , Status , PayementId , OrderDate 
		FROM @tblOrders
	END


CREATE PROCEDURE [dbo].[Save_Payement]
	@Name VARCHAR (100) = NULL,
	@CardNo VARCHAR (50) = NULL,
	@ExpiryDate VARCHAR (50) = NULL,
	@Cvv INT = NULL,
	@Address VARCHAR (MAX) = NULL,
	@PayementMode VARCHAR (10) = 'card',
	@InsertedId INT OUTPUT


AS
BEGIN
	SET NOCOUNT ON;

	--INSERT
	BEGIN
		INSERT INTO DBO.Payement(Name , CardNo , ExpiryDate, CvvNo, Address, PayementMode)
		VALUES (@Name , @CardNo , @ExpiryDate , @Cvv ,@Address , @PayementMode)


		SELECT @InsertedId = SCOPE_IDENTITY();
	END
END

