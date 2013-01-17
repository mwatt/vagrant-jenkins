import org.junit.Test;
import static org.junit.Assert.*;

public class HelloWorldWriterTest{

	@Test
	public void writeHelloWorld(){
		assertEquals(HelloWorldWriter.write(),"hello world!");
	}

}
