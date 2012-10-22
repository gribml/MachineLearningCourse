classdef tnode < handle
    
    properties ( SetAccess = private, GetAccess = public )
<<<<<<< HEAD
        children;
        data;
=======
        op;
        class;
        lengthkids;
    end
    
    properties ( SetAccess = public, GetAccess = public )
        kids;
        index;
        X;
        Y;
>>>>>>> 5c097f662a2f1e0d30336a3f7892cb25a4f451ee
    end
    
    methods
        function obj = tnode( data )
            if ( nargin > 0 )
                obj.op = data;
            end
            obj.lengthkids = 0;
        end
        
        function d = getop( self )
            d = self.op;
        end
        
        function setop( self, d )
            self.op = d;
        end
        
        function n = numberofkids( self )
            n = self.lengthkids;
        end
        
        function new = copy( self )
            % Instantiate new object of the same class.
            new = feval( tnode( self ) );
 
            % Copy all non-hidden properties.
            p = properties( self );
            for i = 1:length( p )
                new.( p{i} ) = self.( p{ i } );
            end
        end
        
        function addkid( self, varargin )
            if ( ~isempty( self.class ) )
                error('a leaf with a class cannot have kids');
            end
            if ( nargin == 1 ) 
                self.lengthkids = self.lengthkids + 1;
                self.kids{ self.lengthkids } = tnode;
            elseif ( nargin == 2 )
                if ( varargin{ 1 } <= self.lengthkids )
                    self.lengthkids = self.lengthkids + 1;
                    self.kids{ self.lengthkids } = tnode;
                    temp = self.kids{ varargin{ 1 } }.copy;
                    self.kids{ varargin{ 1 } } = self.kids{ self.lengthkids };
                    self.kids{ self.lengthkids } = temp;
                else
                    self.lengthkids = self.lengthkids + 1;
                    for i=self.lengthkids:varargin{ 1 }
                        self.kids{ i } = tnode;
                    end
                    self.lengthkids = varargin{ 1 };
                end
            else
                error('wrong number of arguments');
            end
        end
        
        function kid = getkid( self, varargin )
            if ( nargin == 1 )
                kid = self.kids{ self.lengthkids };
            elseif ( nargin == 2 )
                if ( varargin{ 1 } <= self.lengthkids )
                    kid = self.kids{ varargin{ 1 } };
                else
                    error('index out of bound');
                end
            else
                error('wrong number of arguments');
            end
        end
        
        function removekid( self, varargin )
            if ( nargin == 1 )
                self.lengthkids = self.lengthkids - 1;
                self.kids = self.kids( 1:self.lengthkids );
            elseif ( nargin == 2 )
                if ( varargin{ 1 } <= self.lengthkids )
                    self.kids = self.kids( [ 1:varargin{1}-1, varargin{1}+1:self.lengthkids ] );
                    self.lengthkids = self.lengthkids - 1;
                else
                    error('index out of bound');
                end
            end
        end
        
        function bool = isleaf( self )
            bool = ( self.lengthkids == 0 );
        end
        
        function setclass( self, cl )
            if ( self.lengthkids == 0 )
                self.class = cl;
            else
                error('nodes cannot have class label');
            end
        end
        
        function unsetclass( self )
            self.class = [];
        end
        
        function makeleaf( self )
            self.kids = [];
            self.lengthkids = 0;
        end
        
        function o = getclass( self )
            o = self.op;
        end
<<<<<<< HEAD

        function n = nChildren( self )
            n = length( self.children );
=======
        
        function movetokid( self, i )
            if ( i <= self.lengthkids )
                obj = self.kids{ i };
                self.op = obj.op;
                self.class = obj.class;
                self.lengthkids = obj.lengthkids;
                self.kids = obj.kids;
            else
                error('index out of bound');
            end
>>>>>>> 5c097f662a2f1e0d30336a3f7892cb25a4f451ee
        end
        
        function switchkid( self, i, j )
            if ( ( i <= self.lengthkids ) || ( j <= self.lengthkids ) )
                temp = self.kids{ i };
                self.kids{ i } = self.kids{ j };
                self.kids{ j } = temp;
            end
        end
        
    end
    
end