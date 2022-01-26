CREATE TABLE [IR].[Parameter] (
    [ParameterID]     NVARCHAR (15)  NOT NULL,
    [ParameterTypeID] NVARCHAR (15)  NOT NULL,
    [Description]     NVARCHAR (50)  NULL,
    [Value]           NVARCHAR (MAX) NULL,
    [Comment]         NVARCHAR (800) NULL,
    [SoftDeleted]     BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]      ROWVERSION     NOT NULL,
    CONSTRAINT [PK_Parameter] PRIMARY KEY CLUSTERED ([ParameterID] ASC),
    CONSTRAINT [FK_Parameter_ParameterType] FOREIGN KEY ([ParameterTypeID]) REFERENCES [IR].[ParameterType] ([ParameterTypeID])
);

