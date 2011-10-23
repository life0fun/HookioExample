# Some Hook.io example

## Notes
1. EventEmitter2 supports event callback, event ttl, etc.
2. The first hook created will bind to 5000 and become the hook-hub.
3. Event can only be received after the receiver done 'hook::ready', i.e., 
   the receiver hook has successfully connected to the hook hub. 
   Otherwise, the msg will get lost.
4. This is different than zmq, in which event wont get lost event when 
   the receiver not up.
5
