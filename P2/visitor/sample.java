//
// Generated by JTB 1.3.2
//

package visitor;
import syntaxtree.*;
import visitor.sample.MethodArg;

import java.util.*;


/**
 * Provides default methods which visit each node in the tree in depth-first
 * order.  Your visitors may extend this class.
 */
public class sample extends GJDepthFirst<Object, sample.Argument> {


	// Two strings : Class and function Pair
	public static class Pair {
		String cls;
		String meth;

		public  Pair(String equalField, String anotherField) {
			this.cls = equalField;
			this.meth = anotherField;
		}

		@Override
		public boolean equals(Object o) {
			Pair temp = (Pair) o;
			return cls == temp.cls && meth == temp.meth;
		}


		@Override
		public int hashCode() {
			final int prime = 31;
			int result = 1;
			result = prime * result
				+ ((cls == null) ? 0 : cls.hashCode());
			return result;
		}



	}
	
	public static class MethodArg {
		String functionName;
		List<String> arguments;
		String type;
		public MethodArg(String fnName, String Type) {
			this.functionName = fnName;
			this.type = Type;
			arguments = new ArrayList<String>();
		}
		
		@Override
		public boolean equals(Object o) {
			MethodArg temp = (MethodArg) o;
			return this.functionName == temp.functionName;
		}


		@Override
		public int hashCode() {
			final int prime = 31;
			int result = 1;
			result = prime * result
				+ ((functionName == null) ? 0 : functionName.hashCode());
			return result;
		}
	}

	// Two strings : Class and function Pair, and if current variable present in Class or function
	public static class Argument{
		int yn;
		String name, clsname;	
	}
	
	// Two strings : Type of the identifier and the identifier itself  
	public static class TypeIdentifier{
		String type, identifier;
		public TypeIdentifier(String typeField,String identifierField){
			this.type = typeField;
			this.identifier = identifierField;
		}
		
		@Override
		public boolean equals(Object o) {
			TypeIdentifier temp = (TypeIdentifier) o;
			return identifier == temp.identifier;
		}


		@Override
		public int hashCode() {
			final int prime = 31;
			int result = 1;
			result = prime * result
				+ ((identifier == null) ? 0 : identifier.hashCode());
			return result;
		}
	}

	//Store parse number
	// public int trav_num = 1;
	
	// Hash map of Class -> Set 
	public static HashMap<String, HashSet<TypeIdentifier>> ref = new HashMap <String, HashSet<TypeIdentifier>> ();
	// Hash map of (function,Class) -> Set 
	public static HashMap<Pair, HashSet<TypeIdentifier>> scope = new HashMap <Pair, HashSet<TypeIdentifier>> ();
	// Derived Class -> Parent Class 
	public static HashMap<String, String> par = new HashMap <String, String> ();
	
	public static HashMap<String, HashSet<MethodArg>> classToFn = new HashMap <String, HashSet<MethodArg>> ();


	// Auto class visitors--probably don't need to be overridden.

	public Object visit(NodeList n, Argument argu) {
		Object _ret=null;

		int _count=0;
		for ( Enumeration<Node> e = n.elements(); e.hasMoreElements(); ) {
			e.nextElement().accept(this,argu);
			_count++;
		}
		return _ret;
	}

	public Object visit(NodeListOptional n, Argument argu) {
		if ( n.present() ) {
			Object _ret=null;
			int _count=0;
			for ( Enumeration<Node> e = n.elements(); e.hasMoreElements(); ) {
				e.nextElement().accept(this,argu);
				_count++;
			}
			return _ret;
		}
		else
			return null;
	}

	public Object visit(NodeOptional n, Argument argu) {
		if ( n.present() )
			return n.node.accept(this,argu);
		else
			return null;
	}

	public Object visit(NodeSequence n, Argument argu) {
		Object _ret=null;
		int _count=0;
		for ( Enumeration<Node> e = n.elements(); e.hasMoreElements(); ) {
			e.nextElement().accept(this,argu);
			_count++;
		}
		return _ret;
	}

	public Object visit(NodeToken n, Argument argu) { return null; }

	//
	// User-generated visitor methods below
	//

	/**
	 * f0 -> MainClass()
	 * f1 -> ( TypeDeclaration() )*
	 * f2 -> <EOF>
	 */
	public Object visit(Goal n, Argument argu) {
		Object _ret=null;

		// Two traversal, one for symbol table, other for printing
		// This scheme works regardless of ordering of the classes in Code
		// trav_num = 1;
		n.f0.accept(this,argu);
		n.f1.accept(this, argu);
		
//		HashSet<MethodArg> temp = classToFn.get("Tree");
//		
//		for (Iterator iterator = temp.iterator(); iterator.hasNext();) {
//			MethodArg methodArg = (MethodArg) iterator.next();
//			if (methodArg.functionName == "GetKey") {
//				System.out.println(methodArg.arguments);
//			}
//		}
		// trav_num = 2;
		// n.f1.accept(this, argu);

		n.f2.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> "class"
	 * f1 -> Identifier()
	 * f2 -> "{"
	 * f3 -> "public"
	 * f4 -> "static"
	 * f5 -> "void"
	 * f6 -> "main"
	 * f7 -> "("
	 * f8 -> "String"
	 * f9 -> "["
	 * f10 -> "]"
	 * f11 -> Identifier()
	 * f12 -> ")"
	 * f13 -> "{"
	 * f14 -> PrintStatement()
	 * f15 -> "}"
	 * f16 -> "}"
	 */
	public Object visit(MainClass n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		n.f2.accept(this, argu);
		n.f3.accept(this, argu);
		n.f4.accept(this, argu);
		n.f5.accept(this, argu);
		n.f6.accept(this, argu);
		n.f7.accept(this, argu);
		n.f8.accept(this, argu);
		n.f9.accept(this, argu);
		n.f10.accept(this, argu);
		n.f11.accept(this, argu);
		n.f12.accept(this, argu);
		n.f13.accept(this, argu);
		n.f14.accept(this, argu);
		n.f15.accept(this, argu);
		n.f16.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> ClassDeclaration()
	 *       | ClassExtendsDeclaration()
	 */
	public Object visit(TypeDeclaration n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> "class"
	 * f1 -> Identifier()
	 * f2 -> "{"
	 * f3 -> ( VarDeclaration() )*
	 * f4 -> ( MethodDeclaration() )*
	 * f5 -> "}"
	 */
	public Object visit(ClassDeclaration n, Argument argu) {

		Object _ret=null;
		Argument temp = new Argument();

		// Store class Name yn=0(not in function)
		temp.yn = 0;
		temp.clsname = n.f1.f0.tokenImage;


		// Visit all variable declarations, visit all variable declaration in functions

		// if(trav_num==1){
			if (ref.containsKey(n.f1.f0.tokenImage)) {
				System.out.println("Type Error");
				System.exit(0);
			}
			classToFn.put(n.f1.f0.tokenImage, null);
			par.put(n.f1.f0.tokenImage, "Object");
			n.f3.accept(this,temp);
		// }
		
		//Assign parent to point to Base class object
		n.f4.accept(this,temp);

		return _ret;
	}

	/**
	 * f0 -> "class"
	 * f1 -> Identifier()
	 * f2 -> "extends"
	 * f3 -> Identifier()
	 * f4 -> "{"
	 * f5 -> ( VarDeclaration() )*
	 * f6 -> ( MethodDeclaration() )*
	 * f7 -> "}"
	 */
	public Object visit(ClassExtendsDeclaration n, Argument argu) {
		Object _ret=null;

		Argument temp = new Argument();
		// Store class Name yn=0(not in function)
		temp.yn = 0;
		temp.clsname = n.f1.f0.tokenImage;

		// Visit all variable declarations, visit all variable declaration in functions
		// if(trav_num==1){
			if (ref.containsKey(n.f1.f0.tokenImage)) {
				System.out.println("Type Error");
				System.exit(0);
			}
			classToFn.put(n.f1.f0.tokenImage, null);
		   	n.f5.accept(this,temp);
			//Assign Par to point to Base class
			par.put(n.f1.f0.tokenImage, n.f3.f0.tokenImage);
		// }

		n.f6.accept(this,temp);

		return _ret;
	}

	/**
	 * f0 -> Type()
	 * f1 -> Identifier()
	 * f2 -> ";"
	 */

	public Object visit(VarDeclaration n, Argument argu) {
		Object _ret=null;

		//If call from function scope
		if (argu.yn == 1){

			// Function class Pair
			Pair a = new Pair (argu.clsname, argu.name);
			HashSet<TypeIdentifier> set = scope.get(a);

			// If seeing map for first time
			if(set==null)
			{
				set = new HashSet<TypeIdentifier>();
				set.add(new TypeIdentifier((String)n.f0.accept(this,argu),n.f1.f0.tokenImage));
				scope.put(a, set);
			}
			// If class and method already present, add new variable declaration to Set of other declarations
			else{
				set = scope.get(a);
				if (set.contains(new TypeIdentifier(null, n.f1.f0.tokenImage))) {
					System.out.println("Type error");
					System.exit(0);
				}
				set.add(new TypeIdentifier((String)n.f0.accept(this,argu),n.f1.f0.tokenImage));
				scope.put(a, set);
			}

		}

		// Declaration from Class scope
		else{
			HashSet<TypeIdentifier> set = ref.get(argu.clsname);
			// If seeing map for first time
			if (set == null) {
				set = new HashSet<TypeIdentifier>(); 
				set.add(new TypeIdentifier((String)n.f0.accept(this,argu),n.f1.f0.tokenImage));
				ref.put(argu.clsname, set);
			// If class and method already present, add new variable declaration to Set of other declarations
			} else {
				if (set.contains(new TypeIdentifier(null, n.f1.f0.tokenImage))) {
					System.out.println("Type error");
					System.exit(0);
				}
				set.add(new TypeIdentifier((String)n.f0.accept(this,argu),n.f1.f0.tokenImage));
			}

		}

		return _ret;
	}

	/**
	 * f0 -> "public"
	 * f1 -> Type()
	 * f2 -> Identifier()
	 * f3 -> "("
	 * f4 -> ( FormalParameterList() )?
	 * f5 -> ")"
	 * f6 -> "{"
	 * f7 -> ( VarDeclaration() )*
	 * f8 -> ( Statement() )*
	 * f9 -> "return"
	 * f10 -> Expression()
	 * f11 -> ";"
	 * f12 -> "}"
	 */
	public Object visit(MethodDeclaration n, Argument argu) {
		Object _ret=null;
		Argument temp = new Argument();
		temp.yn = 1;
		temp.clsname = argu.clsname;
		temp.name = n.f2.f0.tokenImage;

		//Collect delcaration of variables in traversal 1;
		// if(trav_num==1)
		// {
			if (scope.containsKey(new Pair(argu.clsname,n.f2.f0.tokenImage))) {
				System.out.println("Type error");
				System.exit(0);
			}
			HashSet<MethodArg> set = classToFn.get(argu.clsname);
			if ( set == null) { 
				set = new HashSet<MethodArg>();
				set.add(new MethodArg(n.f2.f0.tokenImage,n.f1.accept(this, argu).toString()));
				classToFn.put(argu.clsname, set);
			}
			else{
				set = classToFn.get(argu.clsname);
				set.add(new MethodArg(n.f2.f0.tokenImage,n.f1.accept(this, argu).toString()));
				classToFn.put(argu.clsname, set);
			}
			n.f4.accept(this, temp);
			n.f7.accept(this, temp);
		// }
		// // print values in traversal two
		// else
		// 	n.f8.accept(this, temp);


		return _ret;
	}

	/**
	 * f0 -> FormalParameter()
	 * f1 -> ( FormalParameterRest() )*
	 */
	public Object visit(FormalParameterList n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> Type()
	 * f1 -> Identifier()
	 */ public Object visit(FormalParameter n, Argument argu) {
		Object _ret=null;

		//If call from function scope
		if (argu.yn == 1){

			// Function class Pair
			Pair a = new Pair (argu.clsname, argu.name);
			HashSet<TypeIdentifier> set = scope.get(a);

			// If seeing map for first time
			if(set==null)
			{
				set = new HashSet<TypeIdentifier>(); 
				set.add(new TypeIdentifier((String)n.f0.accept(this,argu),n.f1.f0.tokenImage));
				scope.put(a, set);
			}
			// If class and method already present, add new variable declaration to Set of other declarations
			else{
				set = scope.get(a);
				set.add(new TypeIdentifier((String)n.f0.accept(this,argu),n.f1.f0.tokenImage));
				scope.put(a, set);
			}
			
			HashSet<MethodArg> temp = classToFn.get(argu.clsname);
			
			for (Iterator iterator = temp.iterator(); iterator.hasNext();) {
				MethodArg methodArg = (MethodArg) iterator.next();
				if (methodArg.functionName == argu.name) {
					methodArg.arguments.add(n.f0.accept(this,argu).toString());
				}
			}

		}

		// Declaration from Class scope
		else{
			HashSet<TypeIdentifier> set = ref.get(argu.clsname);
			// If seeing map for first time
			if (set == null) {
				set = new HashSet<TypeIdentifier>(); 
				set.add(new TypeIdentifier((String)n.f0.accept(this,argu),n.f1.f0.tokenImage));
				ref.put(argu.clsname, set);
			// If class and method already present, add new variable declaration to Set of other declarations
			} else {
				set.add(new TypeIdentifier((String)n.f0.accept(this,argu),n.f1.f0.tokenImage));
			}

		}

		return _ret;
	}

	/**
	 * f0 -> ","
	 * f1 -> FormalParameter()
	 */
	public Object visit(FormalParameterRest n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> ArrayType()
	 *       | BooleanType()
	 *       | IntegerType()
	 *       | Identifier()
	 */
	public Object visit(Type n, Argument argu) {
		Object _ret=null;
		return n.f0.accept(this, argu);

	}

	/**
	 * f0 -> "int"
	 * f1 -> "["
	 * f2 -> "]"
	 */
	public Object visit(ArrayType n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		n.f2.accept(this, argu);
		return "int[]";
	}

	/**
	 * f0 -> "boolean"
	 */
	public Object visit(BooleanType n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		return n.f0.tokenImage;
	}

	/**
	 * f0 -> "int"
	 */
	public Object visit(IntegerType n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		return n.f0.tokenImage;
	}

	/**
	 * f0 -> Block()
	 *       | AssignmentStatement()
	 *       | ArrayAssignmentStatement()
	 *       | IfStatement()
	 *       | WhileStatement()
	 *       | PrintStatement()
	 */
	public Object visit(Statement n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> "{"
	 * f1 -> ( Statement() )*
	 * f2 -> "}"
	 */
	public Object visit(Block n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		n.f2.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> Identifier()
	 * f1 -> "="
	 * f2 -> Expression()
	 * f3 -> ";"
	 */
	public Object visit(AssignmentStatement n, Argument argu) {
		Object _ret=null;

		// Indicator variable telling if var found or not
		int flag = 1;

		// Check current function for object
		Pair a = new Pair (argu.clsname, argu.name);
		HashSet<TypeIdentifier> set = scope.get(a);

		// If seeing map for first time
		String type;
		if(set!=null && (type = contains(set,n.f0.f0.tokenImage)) != null)
		{
			flag=0;
			System.out.println(a.cls + ":" + a.meth + "():"+ type + ":" + n.f0.f0.tokenImage);
		}


		//If not found, check classes recursively(in a do-while loop)
		if(flag==1){

			int found =  0;
			String cur_class= argu.clsname;
			String print_val = argu.clsname;

			do{

				HashSet<TypeIdentifier> abc = ref.get(cur_class);
				if (abc != null && (type = contains(abc,n.f0.f0.tokenImage)) != null){
						found = 1; 
						System.out.println(print_val + ":" + type + ":" + n.f0.f0.tokenImage);
				}

				cur_class = par.get(cur_class);
				print_val = cur_class + ":" + print_val;


			}while(found==0	&& cur_class!="Object");

			if(found==0)
				System.out.println("Variable Not found in File");

		}

		return _ret;
	}

	/**
	 * f0 -> Identifier()
	 * f1 -> "["
	 * f2 -> Expression()
	 * f3 -> "]"
	 * f4 -> "="
	 * f5 -> Expression()
	 * f6 -> ";"
	 */
	public Object visit(ArrayAssignmentStatement n, Argument argu) {

		Object _ret=null;


		// Indicator variable telling if var found or not
		int flag = 1;

		// Check current function for object
		Pair a = new Pair (argu.clsname, argu.name);
		HashSet<TypeIdentifier> set = scope.get(a);
		
		String type;
		// If seeing map for first time
		if(set!=null && (type = contains(set,n.f0.f0.tokenImage)) != null)
		{
			flag=0;
			System.out.println(a.cls + ":" + a.meth + "():"+ type + ":" + n.f0.f0.tokenImage);
		}


		//If not found, check classes recursively(in a do-while loop)
		if(flag==1){

			int found =  0;
			String cur_class= argu.clsname;
			String print_val = argu.clsname;

			do{

				HashSet<TypeIdentifier> abc = ref.get(cur_class);

				if (abc != null){
					
					if ((type = contains(set,n.f0.f0.tokenImage)) != null){
						found = 1; 
						System.out.println(print_val + ":" + type + ":" + n.f0.f0.tokenImage);
					}
				}
				cur_class = par.get(cur_class);
				print_val = cur_class + ":" +print_val;

			}while(found==0	&& cur_class!="Object");

			if(found==0)
				System.out.println("Variable Not found in File");

		}

		return _ret;

	}

	/**
	 * f0 -> IfthenElseStatement()
	 *       | IfthenStatement()
	 */
	public Object visit(IfStatement n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> "if"
	 * f1 -> "("
	 * f2 -> Expression()
	 * f3 -> ")"
	 * f4 -> Statement()
	 */
	public Object visit(IfthenStatement n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		n.f2.accept(this, argu);
		n.f3.accept(this, argu);
		n.f4.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> "if"
	 * f1 -> "("
	 * f2 -> Expression()
	 * f3 -> ")"
	 * f4 -> Statement()
	 * f5 -> "else"
	 * f6 -> Statement()
	 */
	public Object visit(IfthenElseStatement n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		n.f2.accept(this, argu);
		n.f3.accept(this, argu);
		n.f4.accept(this, argu);
		n.f5.accept(this, argu);
		n.f6.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> "while"
	 * f1 -> "("
	 * f2 -> Expression()
	 * f3 -> ")"
	 * f4 -> Statement()
	 */
	public Object visit(WhileStatement n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		n.f2.accept(this, argu);
		n.f3.accept(this, argu);
		n.f4.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> "System.out.println"
	 * f1 -> "("
	 * f2 -> Expression()
	 * f3 -> ")"
	 * f4 -> ";"
	 */
	public Object visit(PrintStatement n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		n.f2.accept(this, argu);
		n.f3.accept(this, argu);
		n.f4.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> OrExpression()
	 *       | AndExpression()
	 *       | CompareExpression()
	 *       | neqExpression()
	 *       | PlusExpression()
	 *       | MinusExpression()
	 *       | TimesExpression()
	 *       | DivExpression()
	 *       | ArrayLookup()
	 *       | ArrayLength()
	 *       | MessageSend()
	 *       | PrimaryExpression()
	 */
	public Object visit(Expression n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "&&"
	 * f2 -> PrimaryExpression()
	 */
	public Object visit(AndExpression n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		n.f2.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "||"
	 * f2 -> PrimaryExpression()
	 */
	public Object visit(OrExpression n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		n.f2.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "<="
	 * f2 -> PrimaryExpression()
	 */
	public Object visit(CompareExpression n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		n.f2.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "!="
	 * f2 -> PrimaryExpression()
	 */
	public Object visit(neqExpression n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		n.f2.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "+"
	 * f2 -> PrimaryExpression()
	 */
	public Object visit(PlusExpression n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		n.f2.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "-"
	 * f2 -> PrimaryExpression()
	 */
	public Object visit(MinusExpression n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		n.f2.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "*"
	 * f2 -> PrimaryExpression()
	 */
	public Object visit(TimesExpression n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		n.f2.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "/"
	 * f2 -> PrimaryExpression()
	 */
	public Object visit(DivExpression n, Argument argu) {
		Object _ret=null;

		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		n.f2.accept(this, argu);

		return _ret;
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "["
	 * f2 -> PrimaryExpression()
	 * f3 -> "]"
	 */
	public Object visit(ArrayLookup n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		n.f2.accept(this, argu);
		n.f3.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "."
	 * f2 -> "length"
	 */
	public Object visit(ArrayLength n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		n.f2.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "."
	 * f2 -> Identifier()
	 * f3 -> "("
	 * f4 -> ( ExpressionList() )?
	 * f5 -> ")"
	 */
	public Object visit(MessageSend n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		n.f2.accept(this, argu);
		n.f3.accept(this, argu);
		n.f4.accept(this, argu);
		n.f5.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> Expression()
	 * f1 -> ( ExpressionRest() )*
	 */
	public Object visit(ExpressionList n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> ","
	 * f1 -> Expression()
	 */
	public Object visit(ExpressionRest n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> IntegerLiteral()
	 *       | TrueLiteral()
	 *       | FalseLiteral()
	 *       | Identifier()
	 *       | ThisExpression()
	 *       | ArrayAllocationExpression()
	 *       | AllocationExpression()
	 *       | NotExpression()
	 *       | BracketExpression()
	 */
	public Object visit(PrimaryExpression n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> <INTEGER_LITERAL>
	 */
	public Object visit(IntegerLiteral n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> "true"
	 */
	public Object visit(TrueLiteral n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> "false"
	 */
	public Object visit(FalseLiteral n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> <IDENTIFIER>
	 */
	public Object visit(Identifier n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		return n.f0.tokenImage;
	}

	/**
	 * f0 -> "this"
	 */
	public Object visit(ThisExpression n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> "new"
	 * f1 -> "int"
	 * f2 -> "["
	 * f3 -> Expression()
	 * f4 -> "]"
	 */
	public Object visit(ArrayAllocationExpression n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		n.f2.accept(this, argu);
		n.f3.accept(this, argu);
		n.f4.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> "new"
	 * f1 -> Identifier()
	 * f2 -> "("
	 * f3 -> ")"
	 */
	public Object visit(AllocationExpression n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		n.f2.accept(this, argu);
		n.f3.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> "!"
	 * f1 -> Expression()
	 */
	public Object visit(NotExpression n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> "("
	 * f1 -> Expression()
	 * f2 -> ")"
	 */
	public Object visit(BracketExpression n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		n.f2.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> Identifier()
	 * f1 -> ( IdentifierRest() )*
	 */
	public Object visit(IdentifierList n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> ","
	 * f1 -> Identifier()
	 */
	public Object visit(IdentifierRest n, Argument argu) {
		Object _ret=null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		return _ret;
	}
	
	private String contains(HashSet<TypeIdentifier> set,String token)
	{
		for (TypeIdentifier s : set) {
			if(s.identifier == token)
				return s.type;
		}
		return null;
	}
}
