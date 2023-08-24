NamedPipeClient and NamedPipeServer are client and server versions of a simple chat program.

These programs demonstrate multithreading, named threads, named pipes, 
form inheritance, overlapped I/O, and synchronization events.

To run the demo
---------------

1. Run the NamedPipeServer on a Windows NT/2000/2003 machine.
2. Run the NamedPipeClient on another client machine, also a Windows NT/2000/2003 machine.

NB: The machines in 1 and 2 can be the same machine.

3. In the NamedPipeServer click Activate.
4. In the NamedPipeClient, specifying an existing NT user name 
   and password, and the server's name. If the machines in step 1 and 2 are the same,
   this step can be skipped. Click Connect.
5. Start entering messages in either NamedPipeServer/NamedPipeClient, and click Send, or
   press Enter.
   

To compile the demo
-------------------

1. Load NamedPipes.bdsgroup
2. From the Project menu, select Build All.


Have fun,   
Chee Wee, Chua,   
Singapore,   
29 Jun 2004.
-----
Originally located at http://cc.embarcadero.com/Item/21893
