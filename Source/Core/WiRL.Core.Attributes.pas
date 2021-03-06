{******************************************************************************}
{                                                                              }
{       WiRL: RESTful Library for Delphi                                       }
{                                                                              }
{       Copyright (c) 2015-2018 WiRL Team                                      }
{                                                                              }
{       https://github.com/delphi-blocks/WiRL                                  }
{                                                                              }
{******************************************************************************}
unit WiRL.Core.Attributes;

interface

uses
  System.SysUtils, System.Classes, System.Rtti, System.Generics.Collections,

  WiRL.Core.Declarations,
  WiRL.http.Core,
  WiRL.Core.Utils;

type

{$REGION 'JAX-Like Attributes'}

  /// <summary>
  ///   The Path attribute's value is a relative URL path indicating where the Delphi
  ///   class will be hosted: for example, /helloworld. You can also embed variables in
  ///   the URLs. For example, you could ask for the name of a user and pass it to the
  ///   application as a variable in the URL: /helloworld/{username}.
  /// </summary>
  PathAttribute = class(TCustomAttribute)
  private
    FValue: string;
  public
    constructor Create(const AValue: string);
    property Value: string read FValue write FValue;
  end;

  /// <summary>
  ///   Base class for all HTTP method's attributes
  /// </summary>
  HttpMethodAttribute = class(TCustomAttribute)
  public
    function Matches(const AMethod: string): Boolean; virtual;
    function ToString: string; override;
  end;

  /// <summary>
  ///   The GET attribute is a request method designator and corresponds to the similarly
  ///   named HTTP method. The Delphi method annotated with this request method
  ///   designator will process HTTP GET requests.
  /// </summary>
  GETAttribute = class(HttpMethodAttribute)
  public
    function Matches(const AMethod: string): Boolean; override;
    function ToString: string; override;
  end;

  /// <summary>
  ///   The POST attribute is a request method designator and corresponds to the
  ///   similarly named HTTP method. The Delphi method annotated with this request method
  ///   designator will process HTTP POST requests.
  /// </summary>
  POSTAttribute = class(HttpMethodAttribute)
  public
    function Matches(const AMethod: string): Boolean; override;
    function ToString: string; override;
  end;

  /// <summary>
  ///   The PUT attribute is a request method designator and corresponds to the similarly
  ///   named HTTP method. The Delphi method annotated with this request method
  ///   designator will process HTTP PUT requests.
  /// </summary>
  PUTAttribute = class(HttpMethodAttribute)
  public
    function Matches(const AMethod: string): Boolean; override;
    function ToString: string; override;
  end;

  /// <summary>
  ///   The DELETE attribute is a request method designator and corresponds to the
  ///   similarly named HTTP method. The Delphi method annotated with this request method
  ///   designator will process HTTP DELETE requests.
  /// </summary>
  DELETEAttribute = class(HttpMethodAttribute)
  public
    function Matches(const AMethod: string): Boolean; override;
    function ToString: string; override;
  end;

  /// <summary>
  ///   The PATCH attribute is a request method designator and corresponds to the
  ///   similarly named HTTP method. The Delphi method annotated with this request method
  ///   designator will process HTTP PATCH requests.
  /// </summary>
  PATCHAttribute = class(HttpMethodAttribute)
  public
    function Matches(const AMethod: string): Boolean; override;
    function ToString: string; override;
  end;

  /// <summary>
  ///   The HEAD attribute is a request method designator and corresponds to the
  ///   similarly named HTTP method. The Delphi method annotated with this request method
  ///   designator will process HTTP HEAD requests.
  /// </summary>
  HEADAttribute = class(HttpMethodAttribute)
  public
    function Matches(const AMethod: string): Boolean; override;
    function ToString: string; override;
  end;

  /// <summary>
  ///   The OPTIONS attribute is a request method designator and corresponds to the
  ///   similarly named HTTP method. The Delphi method annotated with this request method
  ///   designator will process HTTP OPTIONS requests.
  /// </summary>
  OPTIONSAttribute = class(HttpMethodAttribute)
  public
    function Matches(const AMethod: string): Boolean; override;
    function ToString: string; override;
  end;

  /// <summary>
  ///   A list of media types. Each entry may specify a single type or consist of a comma separated list of types. E.g.
  ///   {"text/html, application/pdf"}. <br />Use of the comma-separated form allows definition of a common string
  ///   constant for use on multiple targets
  /// </summary>
  ConsumesAttribute = class(TCustomAttribute)
  private
    FValue: string;
  public
    constructor Create(const AValue: string);
    /// <summary>
    ///   A list of media types
    /// </summary>
    property Value: string read FValue write FValue;
  end;

  /// <summary>
  ///   A list of media types. Each entry may specify a single type or consist of a comma separated list of types. E.g.
  ///   {"text/html, application/pdf"}. <br />Use of the comma-separated form allows definition of a common string
  ///   constant for use on multiple targets
  /// </summary>
  ProducesAttribute = class(TCustomAttribute)
  private
    FValue: string;
  public
    constructor Create(const AValue: string);
    /// <summary>
    ///   A list of media types
    /// </summary>
    property Value: string read FValue write FValue;
  end;

  /// <summary>
  ///   Base class for the *Param attributes
  /// </summary>
  MethodParamAttribute = class(TCustomAttribute)
  private
    FValue: string;
  public
    constructor Create(const AValue: string = '');
    property Value: string read FValue write FValue;
  end;

  /// <summary>
  ///   Binds the value of a URL template parameter or a path segment containing the
  ///   template parameter to a resource method parameter, resource class field, or
  ///   resource class
  /// </summary>
  PathParamAttribute = class(MethodParamAttribute)
  private
    FParamIndex: Integer;
  public
    property ParamIndex: Integer read FParamIndex write FParamIndex;
  end;

  /// <summary>
  ///   Binds the value(s) of a HTTP query parameter to a resource method parameter,
  ///   resource class field, or resource class entity property
  /// </summary>
  QueryParamAttribute = class(MethodParamAttribute);

  /// <summary>
  ///   Binds the value(s) of a form parameter contained within a request entity body to
  ///   a resource method parameter
  /// </summary>
  FormParamAttribute = class(MethodParamAttribute);

  /// <summary>
  ///   Binds the value(s) of a HTTP header to a resource method parameter, resource
  ///   class field, or resource class entity property
  /// </summary>
  HeaderParamAttribute = class(MethodParamAttribute);

  /// <summary>
  ///   Binds the value of a HTTP cookie to a resource method parameter, resource class
  ///   field, or resource class entity property.
  /// </summary>
  CookieParamAttribute = class(MethodParamAttribute);

  /// <summary>
  ///   Binds the value of the HTTP request body to a resource method parameter,
  ///   resource class field, or resource class entity property.
  /// </summary>
  BodyParamAttribute = class(MethodParamAttribute)
  public
    constructor Create;
  end;

  /// <summary>
  ///   WiRL provides the Context attribute to inject a variety of resources in your
  ///   RESTful services. Some of the most commonly injected components are HTTP headers,
  ///   HTTP URL related information.
  /// </summary>
  ContextAttribute = class(TCustomAttribute);

  /// <summary>
  ///   Base class for all auth related attributes.
  /// </summary>
  AuthorizationAttribute = class(TCustomAttribute);

  /// <summary>
  ///   Specifies that all security roles are permitted to access your WiRL resources
  /// </summary>
  PermitAllAttribute = class(AuthorizationAttribute);

  /// <summary>
  ///   Specifies that no security roles are permitted to access your WiRL resources
  /// </summary>
  DenyAllAttribute = class(AuthorizationAttribute);

  /// <summary>
  ///   Specifies the security roles that are permitted to access your WiRL resources
  /// </summary>
  RolesAllowedAttribute = class(AuthorizationAttribute)
  private
    FRoles: TStringList;
  public
    constructor Create(const ARoles: string); overload; virtual;
    constructor Create(const ARoles: TArray<string>); overload; virtual;
    destructor Destroy; override;

    property Roles: TStringList read FRoles;
  end;

  /// <summary>
  ///   This attribute tells WiRL not to destroy the resulting object because it's a
  ///   "global" object.
  /// </summary>
  SingletonAttribute = class(TCustomAttribute);

  AsyncResponseAttribute = class(TCustomAttribute);

  PreMatchingAttribute = class(TCustomAttribute);

  NameBindingAttribute = class(TCustomAttribute);

  PriorityAttribute = class(TCustomAttribute)
  private
    FValue: Integer;
  public
    constructor Create(AValue: Integer);
    property Value: Integer read FValue write FValue;
  end;

  DefaultValueAttribute = class(TCustomAttribute)
  private
    FValue: string;
  public
    constructor Create(const AValue: string);
    property Value: string read FValue write FValue;
  end;


{$ENDREGION}

{$REGION 'WiRL-specific Attributes'}

  /// <summary>
  ///   The <b>ResponseStatus</b> attribute marks a method with the status <b>Code</b>
  ///   and <b>Reason</b> that should be returned. <br />The status code is applied to
  ///   the HTTP response when the handler method is invoked and overrides status
  ///   information set by other means
  /// </summary>
  /// <remarks>
  ///   Borrowed from the spring's ResponseStatus annotation
  /// </remarks>
  ResponseStatusAttribute = class(TCustomAttribute)
  private
    FCode: Integer;
    FReason: string;
  public
    constructor Create(ACode: Integer; const AReason: string = '');

    property Code: Integer read FCode write FCode;
    property Reason: string read FReason write FReason;
  end;

  /// <summary>
  ///   The <b>ResponseRedirection</b> attribute marks a method with the status <b>Code</b>
  ///    (30x) and <b>Reason</b> that should be returned. In addition sets the <b>
  ///   Location</b> for the redirect
  /// </summary>
  ResponseRedirectionAttribute = class(ResponseStatusAttribute)
  private
    FLocation: string;
  public
    constructor Create(ACode: Integer; const ALocation: string; const AReason: string = '');

    property Location: string read FLocation write FLocation;
  end;

  LoginRequiredAttribute = class(TCustomAttribute);

  URLParamAttribute = class(TCustomAttribute)
  private
    FPosition: Integer;
    FDefaultValue: TValue;
  public
    constructor Create(APosition: Integer; const ADefaultValue: TValue); overload;

    constructor Create(APosition: Integer); overload;
    constructor Create(APosition: Integer; const ADefaultValue: string); overload;
    constructor Create(APosition: Integer; ADefaultValue: Integer); overload;
    constructor Create(APosition: Integer; ADefaultValue: Double); overload;
    constructor Create(APosition: Integer; ADefaultValue: Boolean); overload;

    property Position: Integer read FPosition write FPosition;
    property DefaultValue: TValue read FDefaultValue write FDefaultValue;
  end;

  ContentTypeAttribute = class(TCustomAttribute)
  private
    FContentType: string;
  public
    constructor Create(const AContentType: string);
    property ContentType: string read FContentType;
  end;

  RestAttribute = class(TCustomAttribute)
  end;
{$ENDREGION}

implementation

{ URLParamAttribute }

constructor URLParamAttribute.Create(APosition: Integer; const ADefaultValue: string);
begin
  Create(APosition, TValue.From<string>(ADefaultValue));
end;

constructor URLParamAttribute.Create(APosition: Integer; ADefaultValue: Integer);
begin
  Create(APosition, TValue.From<Integer>(ADefaultValue));
end;

constructor URLParamAttribute.Create(APosition: Integer; const ADefaultValue: TValue);
begin
  inherited Create;
  FPosition := APosition;
  FDefaultValue := ADefaultValue;
end;

constructor URLParamAttribute.Create(APosition: Integer; ADefaultValue: Double);
begin
  Create(APosition, TValue.From<Double>(ADefaultValue));
end;

constructor URLParamAttribute.Create(APosition: Integer;
  ADefaultValue: Boolean);
begin
  Create(APosition, TValue.From<Boolean>(ADefaultValue));
end;

constructor URLParamAttribute.Create(APosition: Integer);
begin
  Create(APosition, TValue.Empty);
end;

{ ContentTypeAttribute }

constructor ContentTypeAttribute.Create(const AContentType: string);
begin
  FContentType := AContentType;
end;

{ PathAttribute }

constructor PathAttribute.Create(const AValue: string);
begin
  inherited Create;
  FValue := AValue;
end;

{ ConsumesAttribute }

constructor ConsumesAttribute.Create(const AValue: string);
begin
  inherited Create;
  FValue := AValue;
end;

{ ProducesAttribute }

constructor ProducesAttribute.Create(const AValue: string);
begin
  inherited Create;
  FValue := AValue;
end;

{ MethodParamAttribute }

constructor MethodParamAttribute.Create(const AValue: string);
begin
  inherited Create;
  FValue := AValue;
end;

{ RolesAllowedAttribute }

constructor RolesAllowedAttribute.Create(const ARoles: string);
begin
  Create(ARoles.Split([',']));
end;

constructor RolesAllowedAttribute.Create(const ARoles: TArray<string>);
var
  LRole: string;
begin
  inherited Create;

  FRoles := TStringList.Create;

  for LRole in ARoles do
    FRoles.Add(LRole.Trim);
end;

destructor RolesAllowedAttribute.Destroy;
begin
  FRoles.Free;
  inherited;
end;

{ BodyParamAttribute }

constructor BodyParamAttribute.Create;
begin
  inherited Create('body');
end;

{ HttpMethodAttribute }

function HttpMethodAttribute.Matches(const AMethod: string): Boolean;
begin
  Result := False;
end;

function HttpMethodAttribute.ToString: string;
begin
  Result := '';
end;

{ GETAttribute }

function GETAttribute.Matches(const AMethod: string): Boolean;
begin
  Result := AMethod = TWiRLHttpMethod.GET.ToString;
end;

function GETAttribute.ToString: string;
begin
  Result := TWiRLHttpMethod.GET.ToString;
end;

{ POSTAttribute }

function POSTAttribute.Matches(const AMethod: string): Boolean;
begin
  Result := AMethod = TWiRLHttpMethod.POST.ToString;
end;

function POSTAttribute.ToString: string;
begin
  Result := TWiRLHttpMethod.POST.ToString;
end;

{ PUTAttribute }

function PUTAttribute.Matches(const AMethod: string): Boolean;
begin
  Result := AMethod = TWiRLHttpMethod.PUT.ToString;
end;

function PUTAttribute.ToString: string;
begin
  Result := TWiRLHttpMethod.PUT.ToString;
end;

{ DELETEAttribute }

function DELETEAttribute.Matches(const AMethod: string): Boolean;
begin
  Result := AMethod = TWiRLHttpMethod.DELETE.ToString;
end;

function DELETEAttribute.ToString: string;
begin
  Result := TWiRLHttpMethod.DELETE.ToString;
end;

{ PATCHAttribute }

function PATCHAttribute.Matches(const AMethod: string): Boolean;
begin
  Result := AMethod = TWiRLHttpMethod.PATCH.ToString;
end;

function PATCHAttribute.ToString: string;
begin
  Result := TWiRLHttpMethod.PATCH.ToString;
end;

{ HEADAttribute }

function HEADAttribute.Matches(const AMethod: string): Boolean;
begin
  Result := AMethod = TWiRLHttpMethod.HEAD.ToString;
end;

function HEADAttribute.ToString: string;
begin
  Result := TWiRLHttpMethod.HEAD.ToString;
end;

{ OPTIONSAttribute }

function OPTIONSAttribute.Matches(const AMethod: string): Boolean;
begin
  Result := AMethod = TWiRLHttpMethod.OPTIONS.ToString;
end;

function OPTIONSAttribute.ToString: string;
begin
  Result := TWiRLHttpMethod.OPTIONS.ToString;
end;

{ PriorityAttribute }

constructor PriorityAttribute.Create(AValue: Integer);
begin
  FValue := AValue;
end;

{ DefaultValueAttribute }

constructor DefaultValueAttribute.Create(const AValue: string);
begin
  FValue := AValue;
end;

{ ResponseStatusAttribute }

constructor ResponseStatusAttribute.Create(ACode: Integer; const AReason: string);
begin
  FCode := ACode;
  FReason := AReason;
end;

{ ResponseRedirectionAttribute }

constructor ResponseRedirectionAttribute.Create(ACode: Integer; const ALocation: string; const AReason: string = '');
begin
  inherited Create(ACode, AReason);
  FLocation := ALocation;
end;

end.
