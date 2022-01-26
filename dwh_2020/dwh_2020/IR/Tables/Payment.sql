CREATE TABLE [IR].[Payment] (
    [PaymentID]         INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [PaymentTypeID]     NVARCHAR (15)   NOT NULL,
    [Date]              DATETIME        NOT NULL,
    [ExternalReference] NVARCHAR (50)   NULL,
    [EntityID]          INT             NOT NULL,
    [EntityTypeID]      NVARCHAR (15)   NULL,
    [Amount]            DECIMAL (10, 2) NOT NULL,
    [Name]              NVARCHAR (100)  NULL,
    [SoftDeleted]       BIT             DEFAULT ((0)) NOT NULL,
    [RowVersion]        ROWVERSION      NOT NULL,
    CONSTRAINT [PK_Payment] PRIMARY KEY CLUSTERED ([PaymentID] ASC),
    CONSTRAINT [FK_Payment_PaymentType] FOREIGN KEY ([PaymentTypeID]) REFERENCES [IR].[PaymentType] ([PaymentTypeID])
);

